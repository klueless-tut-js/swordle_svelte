KManager.action :bootstrap do
  action do
    application_name = :swordle_svelte
    director = KDirector::Dsls::BasicDsl
      .init(k_builder,
        template_base_folder:       'svelte',
        on_exist:                   :skip,                      # %i[skip write compare]
        on_action:                  :queue                      # %i[queue execute]
      )
      .data(
        application:                application_name,
        application_description:    'Wordle-Swelte is a daily word game written in Swelte and TailwindCSS',
        application_lib_path:       application_name.to_s,
        author:                     'David Cruwys',
        author_email:               'david@ideasmen.com.au',
        initial_semver:             '1.0.0',
        main_story:                 'As a Developer, I want practice my JS/HTML skills, so that I keep up to date',
        copyright_date:             '2022',
        website:                    'http://appydave.com/websites/swordle-svelte'
      )
      .github(
        active: false,
        repo_name: application_name.to_s,
        organization: 'klueless-tut-js'
      ) do
        create_repository
        # delete_repository
        # list_repositories
        open_repository
        run_command('git init')
        # run_command("gh repo edit -d \"#{dom[:application_description]}\"")
      end
      .package_json(
        active: false
      ) do
        npm_init
        settings(
          version:     dom[:initial_semver],
          description: dom[:application_description],
          author:      dom[:author],
          name:        dom[:application])
        sort
        development

        npm_add_group('svelte')

        remove_script('test')
        add_script('build', 'rollup -c')
        add_script('dev', 'rollup -c -w')
        add_script('start', 'sirv public')
    
        production
        npm_add('sirv-cli')

      end
      .blueprint(
        active: false,
        name: :javascript_packages,
        description: 'add default svelte files',
        on_exist: :write) do

        # don't have support for image assets yet
        # add('public/favicon.png')
        add('public/global.css')
        add('public/index.html')

        add('src/App.svelte')
        add('src/main.js')
        add('README.md')
        add('rollup.config.js')

        # run_command('yarn add -D semantic-release @semantic-release/changelog @semantic-release/git')

        # run_command("git add .; git commit -m 'chore: #{self.options.description.downcase}'; git push")
      end
      .blueprint(
        active: true,
        name: :bin_hook,
        description: 'BIN/Hook structures',
        on_exist: :write) do

        cd(:app)
        
        run_template_script('.runonce/git-setup.sh', dom: dom)

        add('.gitignore')

        # add('.githooks/commit-msg')
        # add('.githooks/pre-commit')

        # run_command('chmod +x .githooks/commit-msg')
        # run_command('chmod +x .githooks/pre-commit')

        # run_command('git config core.hooksPath .githooks') # enable sharable githooks (developer needs to turn this on before editing rep)
        # run_command("git add .; git commit -m 'chore: #{self.options.description.downcase}'; git push")
      end
      # .blueprint(
      #   name: :ci_cd,
      #   description: 'github actions (CI/CD)',
      #   on_exist: :write) do

      #   cd(:app)
      #   # self.dom = OpenStruct.new(parent.options.to_h.merge(options.to_h))

      #   # run_command("gh secret set SLACK_WEBHOOK --body \"$SLACK_REPO_WEBHOOK\"")
      #   # run_command("gh secret set LHCI_GITHUB_APP_TOKEN --body \"$LHCI_GITHUB_APP_TOKEN\"")
      #   # add('.github/workflows/main.yml')
      #   # add('.github/workflows/semver.yml')
      #   # add('.releaserc.json')

      #   # run_command("git add .; git commit -m 'chore: #{self.options.description.downcase}'; git push")
      # end

    # director.k_builder.debug
    # director.builder.logit
    director.play_actions
  end
end

KManager.opts.app_name                    = 'swordle-svelte.com'
KManager.opts.sleep                       = 2
KManager.opts.reboot_on_kill              = 0
KManager.opts.reboot_sleep                = 4
KManager.opts.exception_style             = :short
KManager.opts.show.time_taken             = true
KManager.opts.show.finished               = true
KManager.opts.show.finished_message       = 'FINISHED :)'


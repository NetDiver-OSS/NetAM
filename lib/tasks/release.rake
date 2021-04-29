# frozen_string_literal: true

def version(version)
  "#{version.split('.')[0, 2].join('.')}.x"
end

def update_files(version)
  File.write('VERSION', version)

  json = JSON.parse(File.read('package.json'))
  json['version'] = version

  File.write('package.json', JSON.pretty_generate(json))

  system('sed', '-i', "s/sonar.projectVersion=.*/sonar.projectVersion=#{version}/g", 'sonar-project.properties')
end

namespace :release do
  desc 'Major release tasks'
  task :major, [:version] do |_, args| # rubocop:disable Rails/RakeEnvironment
    system('git', 'checkout', '-b', "release/#{version(args[:version])}", 'dev')

    update_files(args[:version])

    system('./bin/generate_changelog', '-v', args[:version])
  end
end

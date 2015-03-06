require 'github_api'
require 'thor'

class DIB
  desc 'rc STACK RELEASE', 'Find next RC tag'
  long_desc <<-_EOF
    `rc STACK RELEASE` returns the next RC tag to use based on RELEASE.

    Example:
    > dib rc web v0.0.0
    rc/0.0.0-1
    >
_EOF
  method_option :repo_owner, type: :string, aliases: '-t', default: 'porcupo', desc: 'Owner of repo'
  def rc(stack, release)
    # TODO: Replace with role acct token
    github_token = 'XXXXXXXXXX'

    # release: validate and set related variables
    abort 'Invalid release format. Use: "v0.0.0"' unless release =~ /^v\d+\.\d+\.\d+$/
    base_release = release.gsub(/^v(.*)/, '\\1')
    prefix = 'rc/'

    # stack: validate
    stacks = { 'web' => 'frontend', 'api' => 'backend' }
    if stacks[stack].nil? # || stack.nil?
      print 'Invalid stack. Use either of:'
      stacks.each do |k, v|
        print " #{k}"
      end
      abort ''
    end

    # Set up github API connection
    github = Github.new(site: 'https://github.com',
                        endpoint: 'https://api.github.com',
                        oauth_token: github_token
                        )

    # collect tags
    tags = []
    current_tags = github.repos.tags options[:repo_owner], stacks[stack]
    current_tags.each do |t|
      tags << t.name if t.name =~ /^#{prefix}#{base_release}.*$/
    end

    # Find next available tag
    if tags.length == 0
      next_tag = '1'
    else
      next_tag = tags.sort_by { |t| t.split('-')[-1].to_i }[-1].split('-')[-1].to_i + 1
      next_tag = '-' + next_tag.to_s
    end

    # Return tag
    output = prefix + base_release + next_tag
    puts output
    return output
  end
end

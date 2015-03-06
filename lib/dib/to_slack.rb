require 'slack-notifier'
require 'thor'

# Public: Reports various things to slack
# This is a Thor class for a cli subcommand ("dib slack")
class DIB < Thor
  desc 'slack ACTION ENV STACK GIT_REFERENCE STATUS', 'Send Slack notification'
  long_desc <<-_EOF
    `slack ACTION ENV STACK GIT_REFERENCE STATUS` Notifies slack that something happened.

    ACTION:  build, deploy, tag
    ENV:     qa, prod, int, stage
    STACK:   web, qa
    GIT_REF: tag/branch/commit
    STATUS:  fail, pass

    Example:
    > portal slack deploy qa web rc/0.0.0-1 pass
_EOF

  method_option :build_url, type: :string, aliases: '-u', desc: 'Specify build url'
  method_option :channel,   type: :string, aliases: '-c', default: '#doug-test', desc: 'Channel to post to'
  method_option :name,      type: :string, aliases: '-n', default: 'jenkins', desc: 'Post as NAME'
  method_option :icon,      type: :string, aliases: '-i', default: ':jenkins:', desc: 'Post with ICON'

  def slack(action, env, stack, git_ref, status)
    team  = 'slacktest'
    token = 'XXXXXXXXX'

    if action == 'deploy'
      message = "#{stack}: deploying #{git_ref} to #{env}"
    elsif action == 'build'
      message = "#{stack}: building and staging #{git_ref} for deployment"
    elsif action == 'tag'
      message = "#{stack}: #{git_ref} being tagged as #{git_tag}"
    else
      message = "#{stack}: performing #{action} with #{git_ref} and #{env}"
    end

    message += " ([Log](#{options[:build_url]}/console))" if options[:build_url]

    begin
      if status == 'pass'
        message += ': SUCCESS!'
      elsif status == 'fail'
        message += ': FAILED!'
      end
    rescue => e
      abort e.inspect
    end

    notifier = Slack::Notifier.new(team,
                                   token,
                                   channel: options[:channel],
                                   username: options[:name],
                                   icon_emoji: options[:icon]
                                   )
    payload = Slack::Notifier::LinkFormatter.format(message)
    notifier.ping payload
    puts "Notified #{options[:channel]}: #{message}"
  end
end

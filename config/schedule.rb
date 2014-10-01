#
# pmp support crons
#
set :output, {error: 'cron.log', standard: 'cron.log'}

# whenever --set "admin_id=1234&admin_secret=4567&public_id=1234&public_secret=4567" --update-crontab
job_type :pmp_rake, 'cd :path && RAILS_ENV=:environment PRODUCTION_CLIENT_ID=:admin_id PRODUCTION_CLIENT_SECRET=:admin_secret PRODUCTION_PUBLIC_ID=:public_id PRODUCTION_PUBLIC_SECRET=:public_secret bundle exec rake :task --silent :output'

# cache pmp data
every 1.hour do
  pmp_rake 'pmp:stats'
  pmp_rake 'pmp:recent'
end

desc "start"
task :start do
`mv /tmp/node_modules .`
`npm run-script build`
`mv node_modules /tmp`
`lsof -i:8082 -t|xargs kill -9`
end

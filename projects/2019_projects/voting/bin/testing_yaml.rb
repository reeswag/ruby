require 'yaml/store'
p YAML.load("---- foo")
store = YAML::Store.new 'hello.yml'
p store

p File.dirname("store") 

store.transaction {store['votes'] = "Hello"}
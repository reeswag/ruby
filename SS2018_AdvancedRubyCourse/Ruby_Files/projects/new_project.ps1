param($p1)

cp -r skeleton "$p1" 
mv NAME.gemspec "$p1".gemspec
mv bin/NAME bin/"$p1"
mv tests/test_NAME.rb tests/test_"$p1".rb
mv lib/NAME lib/"$p1"
mv lib/NAME.rb lib/"$p1".rb
find . -name "*NAME*" -print
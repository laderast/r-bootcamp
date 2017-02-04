rm *.zip
zip module1.zip module1/*
zip module2.zip module2/*
zip module3.zip module3/*
zip module4.zip module4/*
zip module5.zip module5/*
rsync -avz ~/Code/r-bootcamp/ ~/Dropbox/RBootcamp --exclude='.git'

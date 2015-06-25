# clean up
rm docker_test/hisco*.tar.gz
# run build of package
Rscript -e 'devtools::build(path = "docker_test")'
# cp to docker dir
mv docker_test/hisco*.tar.gz docker_test/hisco.tar.gz
# build docker test
docker build -t junkka/hiscotest docker_test > log.txt

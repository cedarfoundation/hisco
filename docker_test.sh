# clean up
rm tests/docker_test/hisco*.tar.gz
# run build of package
Rscript -e 'devtools::build(path = "tests/docker_test")'
# cp to docker dir
mv tests/docker_test/hisco*.tar.gz tests/docker_test/hisco.tar.gz
# build docker test
docker build -t junkka/hiscotest tests/docker_test

FROM heroku/heroku:18

COPY . /tmp/buildpack

RUN mkdir /tmp/build /tmp/cache /tmp/env /tmp/build/testcachedir
RUN echo "testcachedir" >> /tmp/build/.buildcache
RUN dd if=/dev/zero of=/tmp/build/testcachedir/output.dat  bs=1M  count=1
RUN tar cvzf /tmp/build/testcachedir.tar.gz /tmp/build/testcachedir > /dev/null

CMD /tmp/buildpack/bin/detect /tmp/build && /tmp/buildpack/bin/compile /tmp/build /tmp/cache /tmp/env

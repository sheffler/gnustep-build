FROM ubuntu:24.04
RUN apt update
RUN apt install -y tzdata

RUN uname -a
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /dev/timezone
RUN apt-get update && apt-get install -y git sudo
RUN git clone https://github.com/plaurent/gnustep-build
RUN cp gnustep-build/*.sh .
RUN cp gnustep-build/ubuntu-24.04-clang-18.0-runtime-2.1/*.sh .
RUN cp gnustep-build/ubuntu-24.04-clang-18.0-runtime-2.1/testing/Dockerfile .
RUN chmod +x *.sh
RUN /bin/bash -c "./GNUstep-buildon-ubuntu2404.sh"
RUN [ "/bin/bash", "-c", "export PS1=allow_bash_to_run; source ~/.bashrc; ./demo.sh" ]

CMD [ "/bin/bash", "-c", "export PS1=allow_bash_to_run; source ~/.bashrc; ./demo.sh" ]

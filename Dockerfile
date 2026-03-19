FROM fedora:43

RUN dnf -y upgrade

# TODO: install additional software upfront that might be needed for your workflows
RUN dnf install -y \
    git \
    kubernetes-client \
    jq \
    yq \
    golang

# dont run as root, create user, but give it passwordless sudo
RUN useradd user
RUN echo "user ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER user:user

# install homebrew as additional source of software.
# TODO: RUN brew install xyz does not work in Dockerfile, does not find the command. Works in running container though
RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
RUN echo >> /home/user/.bashrc && \
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"' >> /home/user/.bashrc && \
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"

# install opencode
RUN curl -fsSL https://opencode.ai/install | bash

# pre-create these folders, otherwise a deeply nested mount within
# these creates wrong permissions and prevents startup
RUN mkdir -p ~/.local/state ~/.local/config ~/.local/share

ENTRYPOINT ["/home/user/.opencode/bin/opencode"]
CMD []

##############
# Base Image #
##############

FROM rtvu/docker-ubuntu:24.04

#########################
# Environment Variables #
#########################

ENV ASDF_VERSION=v0.14.0
ENV RUST_VERSION=1.79.0

################
# Install asdf #
################

RUN \
  sudo apt update && \
  sudo DEBIAN_FRONTEND=noninteractive apt install --yes --no-install-recommends \
    curl \
    git \
    && \
  sudo rm -rf /var/lib/apt/lists/* && \
  git clone https://github.com/asdf-vm/asdf.git ${HOME}/.asdf --branch ${ASDF_VERSION} && \
  echo "" >> ${HOME}/.bashrc && \
  echo '. "$HOME/.asdf/asdf.sh"' >> ${HOME}/.bashrc && \
  echo '. "$HOME/.asdf/completions/asdf.bash"' >> ${HOME}/.bashrc

################
# Install Rust #
################

RUN \
  /bin/bash -c '. $HOME/.asdf/asdf.sh && asdf plugin add rust https://github.com/asdf-community/asdf-rust.git' && \
  /bin/bash -c '. $HOME/.asdf/asdf.sh && asdf install rust $RUST_VERSION' && \
  /bin/bash -c '. $HOME/.asdf/asdf.sh && asdf global rust $RUST_VERSION'

###########
# Startup #
###########

CMD ["/bin/bash"]

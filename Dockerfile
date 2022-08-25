FROM ubuntu:latest

LABEL maintainer="giridharsalana@gmail.com"

# Update and upgrade
RUN apt-get update -y && apt-get upgrade -y 

# Install Base Tools
RUN apt-get install sudo software-properties-common git wget curl -y

# Install fish shell
RUN apt-add-repository ppa:fish-shell/release-3 -y && \
	apt-get update -y && \
	apt-get install fish -y 

# Root User Creation
RUN useradd -rm -d /home/giri -s /usr/bin/fish -g root -G sudo -u 1001 giri
RUN echo "giri ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/giri
RUN chmod 044 /etc/sudoers.d/giri
USER giri
ENV USER giri
ENV HOME /home/$USER
WORKDIR /home/$USER

# Fish Shell Customization
# RUN mkdir -p /home/$USER/.config/fish/
RUN git clone https://github.com/Giridharsalana/DotFiles.git
RUN find -name ".*" -exec cp -rf '{}' ~/. \;
# RUN echo "function c\n    clear\nend" > /home/$USER/.config/fish/config.fish
ENV SHELL /usr/bin/fish
ENV LANG=C.UTF-8 LANGUAGE=C.UTF-8 LC_ALL=C.UTF-8

# Tools & Langauges Installation
# Tools
RUN sudo apt-get install unzip xz-utils zip libglu1-mesa openjdk-8-jdk -y

# Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs -o Rust.sh && chmod +x Rust.sh && ./Rust.sh -y && rm Rust.sh 

# Flutter 
# Prepare Android directories and system variables
# RUN mkdir -p $HOME/Android/sdk
# ENV ANDROID_SDK_ROOT $HOME/Android/sdk
# RUN mkdir -p .android && touch .android/repositories.cfg
# # Set up Android SDK
# RUN wget -O sdk-tools.zip https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
# RUN unzip sdk-tools.zip && rm sdk-tools.zip
# RUN mv tools Android/sdk/tools
# RUN cd Android/sdk/tools/bin && yes | ./sdkmanager --licenses
# RUN cd Android/sdk/tools/bin && ./sdkmanager "build-tools;29.0.2" "patcher;v4" "platform-tools" "platforms;android-29" "sources;android-29"
# RUN cd Android/sdk/tools/bin && ./sdkmanager --install "cmdline-tools;latest"
# ENV PATH "$PATH:/home/gitpod/Android/sdk/platform-tools"
# # Download Flutter SDK
# RUN git clone https://github.com/flutter/flutter.git
# ENV PATH "$PATH:/home/$USER/flutter/bin"
# # Run basic check to download Dark SDK
# RUN flutter doctor
# RUN flutter channel stable
# RUN flutter upgrade

# EntryPoint
ENTRYPOINT [ "fish" ]

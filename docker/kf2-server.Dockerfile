FROM steamcmd/steamcmd:alpine

# Variables for reuse
ARG USERNAME="steam"
ARG HOME_DIR="/home/$USERNAME"
ARG STEAM_DIR="$HOME_DIR/.steam"
ARG STEAM_APPS="$HOME_DIR/steamapps"

# Create a new User for running SteamCMD
RUN addgroup -S steam \
    && adduser -S steam -G steam -s /bin/sh

# Move the existing SteamCMD installation to new User
RUN mv /root/.steam/ $STEAM_DIR \
    && chown -R $USERNAME:$USERNAME $STEAM_DIR

# Install the KillingFloor 2 Server
RUN steamcmd +login anonymous \
    +force_install_dir $STEAM_APPS \
    +app_update 232130 validate \
    +exit

# Login as the new User
#USER steam

CMD ["sleep", "10000"]

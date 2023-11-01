FROM ubuntu:focal-20220801

RUN apt-get update && apt-get install -y \
	jq \
	curl \
	python3-pip \
	libx11-6 \
	libxi6 \
	libxxf86vm1 \
	libxrender1 \
	libxfixes3 \
	libgl1 \
	libsm-dev \
	libxkbcommon-x11-0 \
	nano \
	mysql-client \
	ca-certificates \
	gnupg \
	zip \
	dos2unix \
	&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/apt/keyrings
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
RUN echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_21.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list

RUN apt-get update && apt-get install -y \
	nodejs \
	&& rm -rf /var/lib/apt/lists/*

RUN pip3 install yapapi

ADD https://download.blender.org/release/Blender3.6/blender-3.6.5-linux-x64.tar.xz /opt/
RUN tar -xf /opt/blender-3.6.5-linux-x64.tar.xz -C /opt
RUN mv /opt/blender-3.6.5-linux-x64 /opt/blender
RUN rm /opt/blender-3.6.5-linux-x64.tar.xz
RUN ln -s /opt/blender/blender /usr/bin/blender

RUN useradd golem -m

RUN mkdir /home/golem/app
COPY start.sh /home/golem/start.sh
RUN dos2unix /home/golem/start.sh
RUN chmod +x /home/golem/start.sh
RUN chown -R golem:golem /home/golem

USER golem
WORKDIR /home/golem/

RUN mkdir -p /home/golem/.local/share/ya-installer/terms
RUN touch /home/golem/.local/share/ya-installer/terms/testnet-01.tag
RUN curl -sSf https://join.golem.network/as-requestor | bash - || echo "yes"

ENV PATH=${PATH}:/home/golem/.local/bin/:/home/golem/.local/:/usr/bin

EXPOSE 3001

ENTRYPOINT ["/home/golem/start.sh"]
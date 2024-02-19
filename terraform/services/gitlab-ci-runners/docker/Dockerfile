FROM ubuntu:23.10

RUN apt-get update && apt-get install -y  curl

RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 && chmod 700 get_helm.sh && ./get_helm.sh

COPY entrypoint.sh entrypoint.sh
RUN chmod 700 entrypoint.sh && chown 0:0 entrypoint.sh

ENTRYPOINT ["/bin/sh", "entrypoint.sh"]
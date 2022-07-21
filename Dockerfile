FROM rabbitmq:management-alpine AS final

RUN apk update && apk --no-cache -U upgrade
COPY --chown=rabbitmq:rabbitmq  ./erlang.cookie /var/lib/rabbitmq/.erlang.cookie
RUN chmod 400 /var/lib/rabbitmq/.erlang.cookie

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 5672 15672 15692
CMD ["rabbitmq-server"]
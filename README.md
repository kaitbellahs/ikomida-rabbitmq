# ikomida-rabbitmq

The platform message broker.

> Part of the **iKomida** platform. See **[ikomida-k8s-config](https://github.com/kaitbellahs/ikomida-k8s-config)** for the architecture overview of all 31 repositories.

---

## Role

The RabbitMQ image and cluster configuration deployed alongside the services. Seven queues run through it, decoupling everything slow — email, SMS, push, payment work, per-vendor app builds and referral processing — from the request path.

Deployed to Kubernetes from the manifests in `k8s/`.

## Queues

| Queue | Consumer |
|---|---|
| `EMAIL_QUEUE` | [worker-email](https://github.com/kaitbellahs/ikomida-worker-email) |
| `SMS_QUEUE` | [worker-sms](https://github.com/kaitbellahs/ikomida-worker-sms) |
| `PAYMENT_QUEUE` | [worker-payments](https://github.com/kaitbellahs/ikomida-worker-payments) |
| `PUSH_NOTIFICATION_QUEUE` | [worker-push-notification](https://github.com/kaitbellahs/ikomida-worker-push-notification) |
| `VENDOR_PUSH_NOTIFICATION_QUEUE` | [worker-vendor-push-notification](https://github.com/kaitbellahs/ikomida-worker-vendor-push-notification) |
| `APPS_QUEUE` | [worker-apps](https://github.com/kaitbellahs/ikomida-worker-apps) |
| `REFERRAL_QUEUE` | [job-referral](https://github.com/kaitbellahs/ikomida-job-referral) |

## Stack

RabbitMQ · Docker · Kubernetes

## Build

```bash
./gcloud-local-deploy.ps1   # build image and deploy
./reApply.ps1               # re-apply manifests
```

## Status

Built in 2022. The platform is no longer deployed; this repository is published as a record of the work. **The commit history predates generative AI coding assistants.**

## License

Licensed under the [Apache License 2.0](LICENSE) — free for commercial use, provided the copyright notice and [NOTICE](NOTICE) are retained.

Copyright 2022 Khalid Ait Bellahs.

# sample-app

A tiny throwaway container used to test the reusable pipeline in
[kenshoo-workflows](https://github.com/Kenshoo-ops/kenshoo-workflows) and the
admission policy in [kenshoo-platform](https://github.com/Kenshoo-ops/kenshoo-platform).
It has no real functionality: the image is built on Alpine, prints a greeting,
and runs as a non-root user (UID 10001).

## What it is used for

- **Testing the pipeline.** `ci.yml` calls `secure-build` from kenshoo-workflows on every push to `main`, producing a scanned, signed, multi-arch image at `ghcr.io/kenshoo-ops/sample-app` with an SBOM and build provenance.
- **Testing the platform.** kenshoo-platform deploys this image, pinned by digest, as the "signed image that must be admitted" case. Kyverno lets it run because the pipeline signed it, and rejects images that were not signed by the pipeline.

To check an image yourself, see "Verifying an image" in the kenshoo-workflows README.

## Two choices that are deliberate

- **CI runs on pushes to `main` only, with no `pull_request` trigger.** Keyless signing needs an `id-token`, and pull requests from forks and Dependabot do not get one, so a pull request build could not sign.
- **The GHCR package is public.** The cluster pulls images anonymously, so a private package would fail with `ImagePullBackOff`. Never put secrets in this image.

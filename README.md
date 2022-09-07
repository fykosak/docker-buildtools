# Docker FKS buildtools ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/fykosak/buildtools/latest) ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/fykosak/docker-buildtools/Build%20and%20deploy%20Docker%20image)

[🐋 hub.docker.com/r/fykosak/buildtools](https://hub.docker.com/r/fykosak/buildtools)

To run `make` from the current working directory, use:

    docker run -it --rm -v "$PWD":/usr/src/local fykosak/buildtools make

Please keep in mind that the container has no access to files outside of the current working directory, hence `make` from subdirectories containing reference to the parent Makefile will not work.

## Tags

- Use `sha-{short_commit_id}` tags to pin the specific version of the image in the automatic build environments.
- Each branch has a corresponding tag, e.g. `master` is tagged as `master`.
- Each git tag is also a tag of the image. Moreover, if the tag has `(.*)\.(.*)` format, also the `major` tags are created. For example, `FYKOS35.1` is tagged as `FYKOS35.1` and `FYKOS35`.

## Known issues

- All files are created with a `root` user.
- Layer cache can be invalidated by commits from other branches.

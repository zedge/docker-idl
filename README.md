# docker-idl

Docker image for running [`uber/idl`](https://github.com/uber/idl/) easily.

## Usage

Since `idl` requires access to the Git repo you're working with, as well as your Git credentials
to be able to communicate with your remote, a fair bit of magic is required to make it work
smoothly in a VM. The included [`idl.sh`](idl.sh) script takes care of this.

Just use `idl.sh` as you would use `idl` directly:

```
$ ./idl.sh list
```

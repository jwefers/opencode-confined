# Opencode with local llama.cpp, jailed

Opencode is very permissive to cli commands, making running it on your host dangerous.
This repo builds a custom docker image with stock fedora, and run opencode inside it.

This allows opencode to freely do whatever it wants, even install additional software using `dnf` or `brew`.

Mind the TODOs to mount exactly the folder you want to work on into the container.

Also startups llama.cpp locally to use a local model with OpenCode.

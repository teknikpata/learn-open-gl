# open-gl-learning

Working through [LearnOpenGL](https://learnopengl.com) in C++, one Bazel
package per chapter and per exercise. Everything targets OpenGL 3.3 core and
uses GLFW for windows and input.

## Prerequisites

- [Bazelisk](https://github.com/bazelbuild/bazelisk), installed as `bazel`. It
  downloads the Bazel version pinned in `.bazelversion`.
- A C++20 compiler: GCC or Clang on Linux/WSL, MSVC on Windows. If Bazel cannot
  find MSVC on its own, put the path in a `.bazelrc.local` (not checked in):
  ```
  common --repo_env=BAZEL_VC="C:/Program Files/Microsoft Visual Studio/2022/Community/VC"
  ```

## Building and running

```sh
bazel build //...                                 # everything
bazel run //src/textures:textures                 # a chapter's main program
bazel run //src/textures/exercise-3:textures-3    # one of its exercises
```

Programs load their shaders and images using paths relative to the workspace,
like `"src/textures/common/container.jpg"`. `bazel run` starts them from the
runfiles directory, where those paths resolve. Run them with `bazel run`, not
by starting the binary under `build/` directly.

## Layout

```
glad/                OpenGL loader (generated, checked in)
common/              Shader.h, shared by every chapter (//common:shader)
third_party/stb/     stb_image (//third_party/stb:stb_image)
tools/learnopengl.bzl  learnopengl_binary macro: cc_binary + glad + GLFW
src/<chapter>/
  main.cpp           the chapter's main code   -> //src/<chapter>:<chapter>
  common/            the chapter's GLSL and images (//src/<chapter>/common)
  exercise-N/        exercise N               -> //src/<chapter>/exercise-N:<chapter>-N
```

To add an exercise, create `src/<chapter>/exercise-N/main.cpp` and a
`BUILD.bazel` like:

```python
load("//tools:learnopengl.bzl", "learnopengl_binary")

learnopengl_binary(name = "<chapter>-N", deps = ["//src/<chapter>/common"])
```

## CLion

Open the project with the Bazel plugin. The project view is `.bazelproject`.

- Use a **Bazel run** configuration to start a program. A configuration whose
  command is `build` only compiles and never opens a window. Clicking the ▶ icon
  next to a target in a `BUILD.bazel` creates a run configuration for it.
- After adding or renaming packages, run **Bazel → Sync**. If the IDE still
  shows stale targets, use **Bazel → Sync → Non-Incrementally Sync Project with
  BUILD Files**.
- There's no CLion **Clean** for Bazel projects. Run `bazel clean` in the
  terminal instead.

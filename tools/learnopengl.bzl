"""Macros shared by the LearnOpenGL programs under src/."""

load("@rules_cc//cc:cc_binary.bzl", "cc_binary")

def learnopengl_binary(name, srcs = ["main.cpp"], deps = [], **kwargs):
    """A LearnOpenGL program: links glad and GLFW plus any extra deps.

    Args:
      name: target name, e.g. "textures-3".
      srcs: sources; defaults to the package's main.cpp.
      deps: extra deps, usually the chapter's common library.
      **kwargs: passed through to cc_binary.
    """
    cc_binary(
        name = name,
        srcs = srcs,
        deps = ["//glad", "@glfw"] + deps,
        **kwargs
    )

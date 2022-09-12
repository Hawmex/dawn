# Contributing To Dawn

tl;dr keep the following guidelines in mind.

- Use the latest version of `dawn_lints` as your linter.
- Properly document your public APIs via DartDoc comments.
- Add a pull request for your proposed changes and request a review from
  Hawmex.
- Dawn intends to provide unstyled and essential widgets. Other widgets that
  are design-specific or less essential can be created in applications or UI
  kit packages by either using the essential ones in the build function or
  extending any of the available Node classes. For example, Button can be
  created by adding an event listener to Text, while you can create Video with
  VideoNode that extends the PaintedNode. I made this decision due to these
  reasons:
  1. Each design system can have an implementation of Video, for example,
     according to its guidelines.
  2. Not to force a design system like Material on a framework level.
  3. To see a diverse set of UI kits in Dawn's ecosystem by giving developers
     freedom is indeed in the best interests of Dawn and its users.

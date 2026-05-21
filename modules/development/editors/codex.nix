{
  settings,
  lib,
  pkgs,
  ...
}:
{
  home-manager.users.${settings.user.username} = {
    home.file.".codex/AGENTS.md".text = ''
      # Global AI Coding Instructions

      Before making changes:

      1. Read and follow all rules inside the `.ai/` directory.
      2. Prioritize:
        - explicit user instructions
        - existing architecture
        - repository conventions
        - framework best practices
      3. Preserve existing behavior unless explicitly instructed otherwise.
      4. Avoid broad refactors and unrelated changes.
      5. Reuse existing utilities, composables, and components before creating new ones.
      6. Keep edits minimal, focused, and maintainable.
      7. Do not hallucinate APIs, files, directories, or behavior.
      8. Validate imports, types, and consistency before finishing changes.
      9. Avoid unnecessary dependencies and abstractions.
      10. Ask for clarification when requirements are ambiguous.
      11. Prefer pnpm for JavaScript and TypeScript package management.
      12. Avoid npm unless explicitly requested.
      13. Prefer existing project tooling and conventions.

      Always read relevant files completely before editing.
    '';
  };
}

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

      1. Preserve existing behavior unless explicitly instructed otherwise.
      2. Avoid broad refactors and unrelated changes.
      3. Reuse existing utilities, composables, and components before creating new ones.
      4. Keep edits minimal, focused, and maintainable.
      5. Do not hallucinate APIs, files, directories, or behavior.
      6. Validate imports, types, and consistency before finishing changes.
      7. Avoid unnecessary dependencies and abstractions.
      8. Ask for clarification when requirements are ambiguous.
      9. Prefer pnpm for JavaScript and TypeScript package management.
      10. Avoid npm unless explicitly requested.
      11. Prefer existing project tooling and conventions.

      Always read relevant files completely before editing.
    '';

    # home.file.".codex/config.toml".source = (pkgs.formats.toml { }).generate "config.toml" {
    #   personality = "pragmatic";
    #   projects = {
    #     "/data/github" = {
    #       trust_level = "trusted";
    #     };
    #   };
    #   plugins = {
    #     "github@openai-curated" = {
    #       enabled = true;
    #     };
    #   };
    # };

  };
}

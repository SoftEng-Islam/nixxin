{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Open-source IDE For exploring and testing APIs.
    bruno

    # cross-platform API client for GraphQL, REST, WebSockets, SSE and gRPC. With Cloud, Local and Git storage.
    insomnia

    postman
  ];
}

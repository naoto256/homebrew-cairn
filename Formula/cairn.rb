class Cairn < Formula
  desc "Local, symbol-aware code index for AI coding agents"
  homepage "https://github.com/naoto256/cairn"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/naoto256/cairn/releases/download/v0.8.9/cairn-v0.8.9-aarch64-apple-darwin.tar.gz"
      sha256 "b02ae3da373e21c55bed8420ff86b2ea5dc615b1e8fa77441d7fa424491cfac2"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/naoto256/cairn/releases/download/v0.8.9/cairn-v0.8.9-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "af6ba4a3ae27905b606625baaf4dfdf4737e594a1888bec7dfce74d45d71c1fc"
    end
  end

  def install
    bin.install "cairn"
    pkgshare.install "README.md", "LICENSE-APACHE", "LICENSE-MIT"
  end

  service do
    run [opt_bin/"cairn", "daemon"]
    environment_variables PATH: std_service_path_env
    keep_alive true
    log_path var/"log/cairn-daemon.stdout.log"
    error_log_path var/"log/cairn-daemon.stderr.log"
  end

  def caveats
    <<~EOS
      To register a repo with cairn:
        cairn ctl repo register --alias <name> /path/to/repo

      To start the daemon automatically:
        brew services start cairn

      For the Claude Code plugin integration:
        claude plugin marketplace add naoto256/cairn
        claude plugin install cairn@naoto256-cairn

      For the Codex plugin integration:
        codex plugin marketplace add naoto256/cairn
        codex plugin add cairn@naoto256-cairn
    EOS
  end

  test do
    assert_match "cairn 0.8.9", shell_output("#{bin}/cairn --version")
  end
end

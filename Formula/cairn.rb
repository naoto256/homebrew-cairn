class Cairn < Formula
  desc "Local, symbol-aware code index for AI coding agents"
  homepage "https://github.com/naoto256/cairn"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/naoto256/cairn/releases/download/v0.8.8/cairn-v0.8.8-aarch64-apple-darwin.tar.gz"
      sha256 "5be8f0506780560009bc7345cb7c9b16869f81f12114ce4e6f86cec643676de1"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/naoto256/cairn/releases/download/v0.8.8/cairn-v0.8.8-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "343581c3ce6ffc956a8b4b1e9fbe5de1d0a3c7623c47a652a5d2b675faf124f1"
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
    assert_match "cairn 0.8.8", shell_output("#{bin}/cairn --version")
  end
end

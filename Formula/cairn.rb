class Cairn < Formula
  desc "Local, symbol-aware code index for AI coding agents"
  homepage "https://github.com/naoto256/cairn"
  version "0.7.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/naoto256/cairn/releases/download/v#{version}/cairn-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "bb9462e1054b1738986fd6668f6adcefc71965aa4ea58b9f99f0250e9a7dd288"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/naoto256/cairn/releases/download/v#{version}/cairn-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "641db736b24ee93654eaeee6c6875cc47cbf17920fe411f1c52d52a8933f9e3d"
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
    log_path var/"log/cairn-daemon.log"
    error_log_path var/"log/cairn-daemon.log"
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
    assert_match "cairn 0.7.0", shell_output("#{bin}/cairn --version")
  end
end

class Cairn < Formula
  desc "Local, symbol-aware code index for AI coding agents"
  homepage "https://github.com/naoto256/cairn"
  version "0.4.2"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/naoto256/cairn/releases/download/v#{version}/cairn-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "21db635924b1d89d3f0b824cdafc332628fd19aa100f3e7a2c1e8f3c353d3784"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/naoto256/cairn/releases/download/v#{version}/cairn-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "68493aa552713d602077f4e4546cb8382a1eec12bb85f096352314c310a6ace9"
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
        cairn ctl register-repo --alias <name> /path/to/repo

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
    assert_match "cairn 0.4.2", shell_output("#{bin}/cairn --version")
  end
end

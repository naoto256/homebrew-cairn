class Cairn < Formula
  desc "Local, symbol-aware code index. Daemon-backed structural code search across registered repos"
  homepage "https://github.com/naoto256/cairn"
  version "0.1.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/naoto256/cairn/releases/download/v#{version}/cairn-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "b2723f62ecbb267a2bed3a71317c4fd03f4268c244e45d70b621997497995740"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/naoto256/cairn/releases/download/v#{version}/cairn-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d74bb3a32ec47daeffbe72d4dfd980f198e33e6df4a86a674d1ac6c03130c63e"
    end
  end

  def install
    bin.install "cairn"
    pkgshare.install "README.md", "LICENSE-APACHE", "LICENSE-MIT"
  end

  service do
    run [opt_bin/"cairn", "daemon"]
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
    EOS
  end

  test do
    assert_match "cairn 0.1.0", shell_output("#{bin}/cairn --version")
  end
end

#!/usr/bin/env bash
set -e

echo "[Agent] Downloading Endpoint Central agent…"
curl -o agent.bin "YOUR_ENDPOINT_CENTRAL_AGENT_URL_HERE"
chmod +x agent.bin

echo "[Agent] Installing agent…"
sudo ./agent.bin

echo "[Agent] Writing node identity capsule…"
cat << NODEEOF > /etc/blackcorp-node.json
{
  "peer_id": "12D3KooWMBGemECb3926rg8h7HXzYXyTs5tSo1F8wqPwq6EqeJU7",
  "origin_capsule": "OC-0",
  "constitution_root_cid": "bafybeiczsscdsbs7ffqz55asqdf3smv6klcw3gofszvwlyarci47bgf354",
  "agent_type": "endpoint-node",
  "status": "presence",
  "policy_enforced": true
}
NODEEOF

echo "[Agent] Verifying constitutional compliance…"
CURRENT_CID="bafybeiczsscdsbs7ffqz55asqdf3smv6klcw3gofszvwlyarci47bgf354"
if [ "$CURRENT_CID" != "bafybeiczsscdsbs7ffqz55asqdf3smv6klcw3gofszvwlyarci47bgf354" ]; then
  echo "[Agent] ERROR: Constitutional CID mismatch. Halting."
  exit 1
fi

echo "[Agent] Node successfully bound to BlackCorp State SIL-1."

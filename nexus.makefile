.PHONY: build

build:
	@if [ -f nexus_build_result.yaml ]; then \
		echo "nexus_build_result.yaml already exists, skipping build."; \
	else \
		git submodule update --init --recursive 2>/dev/null || true; \
		forge build; \
		echo "language: solidity" > nexus_build_result.yaml; \
		echo "build_targets:" >> nexus_build_result.yaml; \
		echo "  - ." >> nexus_build_result.yaml; \
		echo 'installation_script: "forge build"' >> nexus_build_result.yaml; \
		echo 'run_test_command: "forge test"' >> nexus_build_result.yaml; \
		echo 'developer_note: ""' >> nexus_build_result.yaml; \
		echo 'blocking_error: ""' >> nexus_build_result.yaml; \
	fi

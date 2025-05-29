# Makefile for Flutter project management

# Location of pubspec.yaml
PUBSPEC := pubspec.yaml

# Check if pubspec.yaml exists
ifeq (,$(wildcard $(PUBSPEC)))
$(error "pubspec.yaml not found. Run this Makefile from the root of your Flutter project.")
endif

.PHONY: get build clean

# Run flutter pub get
get:
	flutter pub get

# Run build_runner
gen:
	flutter pub run build_runner build --delete-conflicting-outputs

# Clean build files
clean:
	flutter clean

# Generate usecase [make usecase entity=user operation=create_user]
usecase:
	@if [ -z "$(entity)" ] || [ -z "$(operation)" ]; then \
		echo "❌ Error: entity and operation are required"; \
		echo "Usage: make usecase entity=category operation=get_categories [return_type=bool]"; \
		exit 1; \
	fi
	@dart lib/core/generate/generate_usecase.dart $(entity) $(operation)
	@dart lib/core/generate/generate_usecase_provider.dart $(entity) $(operation)

# Generate entity [make entity entity=note]
entity:
	@if [ -z "$(entity)" ]; then \
		echo "❌ Error: entity is required"; \
		echo "Usage: make entity entity=note"; \
		exit 1; \
	fi
	@dart lib/core/generate/generate_entity.dart $(entity)

# Generate page [make page page=book]
page:
	@if [ -z "$(page)" ]; then \
		echo "❌ Error: page is required"; \
		echo "Usage: make page page=book"; \
		exit 1; \
	fi
	@dart lib/core/generate/generate_page.dart $(page)
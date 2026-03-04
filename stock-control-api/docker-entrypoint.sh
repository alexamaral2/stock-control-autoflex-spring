#!/bin/sh

./mvnw spring-boot:run -Dspring-boot.run.jvmArguments="-Dserver.address=0.0.0.0" &
SPRING_PID=$!

echo "Watching for changes using polling mode..."
last_hash=$(find /work/src/main -type f -exec md5sum {} +)

while true; do
  sleep 2
  current_hash=$(find /work/src/main -type f -exec md5sum {} +)

  if [ "$current_hash" != "$last_hash" ]; then
    echo "Change detected! Recompiling..."
    ./mvnw compile -o -DskipTests
    last_hash="$current_hash"
  fi
done
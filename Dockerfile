# Use a standard Python image
FROM python:3.11-slim-bookworm

# Install uv
COPY --from=ghcr.io/astral-sh/uv:latest /uv /bin/uv

# Set working directory
WORKDIR /app

# Enable bytecode compilation
ENV UV_COMPILE_BYTECODE=1
ENV UV_LINK_MODE=copy

# Copy dependency files
COPY pyproject.toml uv.lock ./

# Install dependencies
RUN uv sync --frozen --no-install-project --no-dev

# Add .venv to PATH
ENV PATH="/app/.venv/bin:$PATH"

# Copy application code
COPY bot.py .

# Expose the port
EXPOSE 7860

# Default command
CMD ["python", "bot.py", "--host", "0.0.0.0", "--port", "7860"]
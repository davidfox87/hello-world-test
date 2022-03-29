FROM python:3.9-alpine as builder

COPY . /src
RUN pip install --user fastapi uvicorn

FROM python:3.9-alpine as app
COPY --from=builder /root/.local /root/.local
COPY --from=builder /src/app .

ENV PATH=/root/.local:$PATH
EXPOSE 5000

CMD ["python3", "main.py"]
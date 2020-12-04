 
FROM python:3.7.5-slim-buster AS compile-image

 
ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

 
RUN pip install --upgrade pip && pip install pip-tools
COPY ./app-demo-frontend/requirements  .
RUN pip-compile requirements > requirements.txt && pip-sync
RUN pip install -r requirements.txt

 
FROM python:3.7.5-slim-buster AS runtime-image
 
COPY --from=compile-image /opt/venv /opt/venv
WORKDIR /app


RUN addgroup --system web_usr && adduser --system --no-create-home --group web_usr
RUN chown -R web_usr:web_usr /app && chmod -R 755 /app
 
USER web_usr

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
 
COPY ./app-demo-frontend/ /app
ENV PATH="/opt/venv/bin:$PATH"
 
CMD python /app/main.py

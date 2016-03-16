FROM gcr.io/generic-notebooks/binder-base

USER root

# Add R dependencies
RUN apt-get update
RUN apt-get install -y r-base libzmq3-dev

COPY install-irkernel.R /home/install-irkernel.R

RUN R --no-save < /home/install-irkernel.R
USER main


USER main

ADD . $HOME/notebooks

USER root
RUN chown -R main:main $HOME/notebooks
USER main

# Convert notebooks to the current format
# RUN find $HOME/notebooks -name '*.ipynb' -exec ipython nbconvert --to notebook {} --output {} \;
RUN find $HOME/notebooks -name '*.ipynb' -exec ipython trust {} \;

WORKDIR $HOME/notebooks


FROM tul11/cluster_migration:c4

COPY decider_logic.py decider_logic.py
COPY custom_logic.py custom_logic.py

RUN chmod +x decider_logic.py
RUN chmod +x custom_logic.py

RUN chmod 777 decider.txt

Development Overview
====================

Controller Development
-----------------------

First, build the controller container:

.. code:: bash

   docker compose build controller

Then enter the container using ``docker run``:

.. code:: bash

   docker run -it controller bash

The entry point for the controller is the following:

.. code:: bash

   /usr/bin/python3 /app/main.py --config $CONFIG

Changes can be made and tested either inside the container, or you can rebuild when you want to test.

UE-Based Attack Development
---------------------------

When developing attacks in the UE, the ``srsue`` directory contains all the source code. A good place to start is the ``hdr`` directory, which contains headers specific to each layer of the stack.

We recommend adding an argument to ``main.cc`` like the following:

.. code:: c++

   ("rrc.some_attack_argument",
      bpo::value<int>(&args->rrc.some_attack_argument)->default_value(-1),
      "Some argument for an attack")

Then, the argument can be accessed in the ``rrc_args_t`` struct during execution.

**NOTE:** Adding too much logic to any of the UE threads can cause timing issues with the gNB, so keep speed and efficiency in mind.

Standalone Attack Development
------------------------------

To make a standalone attack work with the system, add a class to the controller for starting and monitoring its container.  

The guide for the controller’s monitoring thread API can be found in the :hoverxref:`Monitor Thread API <monitor_thread_api>` section.




# mpi-docker-setup

This repository contains scripts and instructions to set up a Docker container for running MPI (Master Patient Index) applications. A Master Patient Index (MPI), sometimes called a Client Registry (CR), is a foundational piece of any regional or national health system. Fundamentally, a MPI solution seeks to create a single master list of patients across a jurisdiction and to provide a cross-reference of the various identifiers used by local systems in a region to identify a patient.

## Prerequisites

- Docker installed on your system.
- git installed
## Getting Started

Follow these steps to set up and use the MPI Docker container:

<ol>
        <ul>
                Go to
                <li>
                        <code>cd /any/path</code>
                </li>
        </ul>
        <br>
        <ul>
                Clone the Repository
                <li>
                        <code>git clone https://github.com/csaude/mpi-docker-setup.git</code>
                </li>
                <li>
                        <code>cd mpi-docker-setup</code>
                </li>
        </ul>
        <br>
        <ul>
        Copy a env file
                <li>
                        <code>cp sante-db-mpi-template.env mpi.env</code>
                </li>
                <li>
                        <pre>Provide the necessary values for properties in mpi.env </pre>
                </li>
                <li>
                        Copy the env file to profile.d directory
                       <code>
                                cp mpi.env /etc/profile.d/
                                . /etc/profile.d/mpi.env
                        </code>
                </li>
        </ul>
        <br>
        <ul>
                Install the Project
                <li>
                        <code>./install_mpi.sh</code>
                </li>
                <li>
                        <pre>Wait until all the containers start</pre>
                </li>
                </li>
                 <li>
                        <pre>After all the containers started, then you need to restart a specific containers, in order to load the binding files related to the rules of match.
                        </pre>
                </li>
        </ul>
        <br>

</ol>

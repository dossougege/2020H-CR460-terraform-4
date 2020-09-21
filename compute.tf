### VM CANARD
resource "google_compute_instance" "canard" {
  name         = "canard"
  machine_type = "f1-micro"
  zone         = "us-east1-c"
  tags         = ["public-web"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }
  network_interface {
    subnetwork = google_compute_subnetwork.prod-dmz.name
    access_config {
    }
  }
  metadata_startup_script = "apt-get -y update && apt-get -y upgrade && apt-get -y install apache2 && systemctl start apache2"
}

#### VM MOUTON
resource "google_compute_instance" "mouton" {
  name         = "mouton"
  machine_type = "f1-micro"
  zone         = "us-east1-c"
  tags         = ["public-web"]

  boot_disk {
    initialize_params {
      image = "fedora-coreos-cloud/fedora-coreos-stable"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.prod-interne.name
    access_config {

    }
  }
  metadata_startup_script = "apt-get -y update && apt-get -y upgrade"
}

#### VM Cheval
resource "google_compute_instance" "cheval" {
  name         = "cheval"
  machine_type = "f1-micro"
  zone         = "us-east1-c"
  tags         = ["traitement"]

  boot_disk {
    initialize_params {
      image = "fedora-coreos-cloud/fedora-coreos-stable"
    }
  }
  network_interface {
    subnetwork = google_compute_subnetwork.prod-traitement.name
  }
  metadata_startup_script = "apt-get -y update && apt-get -y upgrade"
}
### VM FERMIER
resource "google_compute_instance" "fermier" {
  name         = "fermier"
  machine_type = "f1-micro"
  zone         = "us-east1-c"
  #tags         = ["reseaupardef"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
    }
  }

  network_interface {
  network = "default"
  #access_config {

  # }
}
metadata_startup_script = "apt-get -y update && apt-get -y upgrade"
}
#  resource "google_compute_instance" "etcd2" {
#    name         = "etcd2"
#    machine_type = "f1-micro"
#    zone         = "us-east1-c"
#    tags         = ["backend"]

#    boot_disk {
#      initialize_params {
#        image = "fedora-coreos-cloud/fedora-coreos-stable"
#      }
#    }

#    network_interface {
#      subnetwork = google_compute_subnetwork.mtl-backend.name
#    }
#}

#      name         = "etcd3"
#      machine_type = "f1-micro"
#      zone         = "us-east1-c"
#      tags         = ["backend"]

#      boot_disk {
#        initialize_params {
#          image = "fedora-coreos-cloud/fedora-coreos-stable"
#        }
#      }

#      network_interface {
#        subnetwork = google_compute_subnetwork.mtl-backend.name

#      }
#}


#resource "google_compute_instance_template" "cr460-worker-template" {
#  name                 = "cr460-worker-template"
#  tags                 = ["workload"]
#  machine_type         = "f1-micro"
#  region               = "us-east1"
#  can_ip_forward       = false

  // Create a new boot disk from an image
#  disk {
#    source_image = "fedora-coreos-cloud/fedora-coreos-stable"
#    auto_delete = true
#    boot = true
#  }

#  network_interface {
#    subnetwork = google_compute_subnetwork.mtl-workload.name
#  }

#}

#resource "google_compute_instance_group_manager" "cr460-workload-gm" {
#  name        = "cr460-workload-gm"
#  base_instance_name = "worker"
#  version {
#    instance_template  = google_compute_instance_template.cr460-worker-template.self_link
#    name               = "primary"
#  }
#  zone               = "us-east1-c"

#}

#resource "google_compute_autoscaler" "cr460-autoscaler" {
#  name   = "cr460-autoscaler"
#  zone   = "us-east1-c"
#  target = google_compute_instance_group_manager.cr460-workload-gm.self_link

#  autoscaling_policy {
#    max_replicas    = 5
#    min_replicas    = 2
#    cooldown_period = 60

#    cpu_utilization {
#      target = 0.5
#    }
#  }
#}
/*resource "google_compute_autoscaler" "cr460-autoscaler" {
  name   = "cr460-autoscaler"
  zone   = "us-east1-c"
  target = google_compute_instance_group_manager.cr460-workload-gm.self_link

  autoscaling_policy = {
    max_replicas    = 5
    min_replicas    = 2
    cooldown_period = 60

    cpu_utilization {
      target = 0.5
    }
  }
}*/

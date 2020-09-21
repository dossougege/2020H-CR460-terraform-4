### Reseaau par defaut
resource "google_compute_network" "devoir1" {
  name                    = "devoir1"
  auto_create_subnetworks = "false"
}

#### Sous Reseau prod dmz Canard
resource "google_compute_subnetwork" "prod-dmz" {
  name          = "prod-dmz"
  ip_cidr_range = "172.16.3.0/24"
  region        = "us-east1"
  network       = google_compute_network.devoir1.self_link
}

##### Sous Reseau traitement - Cheval
resource "google_compute_subnetwork" "prod-traitement" {
  name          = "prod-traitement"
  ip_cidr_range = "10.0.2.0/24"
  network       = google_compute_network.devoir1.self_link
  region        = "us-east1"
}
#### Mouton
resource "google_compute_subnetwork" "prod-interne" {
  name          = "prod-interne"
  ip_cidr_range = "10.0.3.0/24"
  region        = "us-east1"
  network       = google_compute_network.devoir1.self_link
}

#resource "google_compute_subnetwork" "prod-backend" {
#  name          = "prod-backend"
#  ip_cidr_range = "10.0.3.0/24"
#  network       = google_compute_network.devoir1.self_link
#  region        = "us-east1"
#}

### FIREWALL
resource "google_compute_firewall" "ssh-public" {
  name    = "ssh-public"
  network = google_compute_network.devoir1.name
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  target_tags=["public-web"]
}

resource "google_compute_firewall" "web-public" {
  name    = "web-public"
  network = google_compute_network.devoir1.name
  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }
  target_tags=["public-web"]
}

resource "google_compute_firewall" "ssh-traitement" {
  name    = "ssh-traitement"
  network = google_compute_network.devoir1.name
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  target_tags=["traitement"]
}

resource "google_compute_firewall" "internal-control" {
  name    = "internal-control"
  network = google_compute_network.devoir1.name

  allow {
    protocol = "tcp"
    ports    = ["22", "2846", "5462"]
  }

  source_ranges = ["10.0.3.0/24" ]
  target_tags = ["traitement"]
}


#resource "google_dns_record_set" "jump" {
#  name = "jump.cloudlab.matbilodeau.dev."
#  type = "A"
#  ttl  = 300

#  managed_zone = "cloudlab"

#  rrdatas = [google_compute_instance.jump.network_interface.0.access_config.0.nat_ip]
#}


#resource "google_dns_record_set" "vault" {
#  name = "vault.cloudlab.matbilodeau.dev."
#  type = "A"
#  ttl  = 300

#  managed_zone = "cloudlab"

#  rrdatas = [google_compute_instance.vault.network_interface.0.access_config.0.nat_ip]
#}

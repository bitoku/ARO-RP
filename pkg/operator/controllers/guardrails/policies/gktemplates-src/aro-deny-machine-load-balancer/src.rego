package arodenymachineloadbalancer

import future.keywords.in

violation[{"msg": msg}] {
  ilb = input.review.object.spec.template.spec.providerSpec.value.internalLoadBalancer
  ilb != ""
  msg := "internalLoadBalancer must not be set."
} {
  plb = input.review.object.spec.template.spec.providerSpec.value.publicLoadBalancer
  not plb in {"", input.parameters.loadBalancerName}
  msg := "publicLoadBalancer must be the default or empty"
}


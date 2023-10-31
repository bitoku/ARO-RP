package arodenymachineloadbalancer

violation[{"msg": msg}] {

  input.review.object.spec.template.spec.providerSpec.value.internalLoadBalancer != ""
  msg := "internalLoadBalancer must not be set."
}


@ManyToOne
@JoinColumn(name = "em_dp_id")
private Department department;
@ManyToMany(fetch = FetchType.EAGER)
@JoinTable(name = "employee_skill",
    joinColumns = @JoinColumn(name = "es_em_id"),
    inverseJoinColumns = @JoinColumn(name = "es_sk_id"))
private Set<Skill> skillList;

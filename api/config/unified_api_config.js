const unifiedApiConfig = {
  apis: {
    salary: { enabled: true, showOnHome: true },
    citizenAccount: { enabled: true, showOnHome: true },
    socialSecurity: { enabled: true, showOnHome: true },
    hafiz: { enabled: true, showOnHome: true },
    reef: { enabled: false, showOnHome: false },
    sakani: { enabled: false, showOnHome: false },
    tamheer: { enabled: false, showOnHome: false },
    productive: { enabled: false, showOnHome: false }
  }
};

if (typeof module !== 'undefined') {
  module.exports = unifiedApiConfig;
}

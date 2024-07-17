export default({
  title: 'Monet All',
  lang: 'en',
  description: 'Monet coloring integration Magisk module',
  cleanUrls: true,
  // srcDir: './docs',
  lastUpdated: true,
  themeConfig: {
    nav: nav(),
    outlineTitle: 'On this page',
    darkModeSwitchLabel: 'Appearance',
    sidebarMenuLabel: 'Menu',
    returnToTopLabel: 'Return to top',
    sidebar: {
      '/en/guide/': sidebarGuide()
    },
    lastUpdatedText: 'Last updated',
    docFooter: {
      prev: 'Last page',
      next: 'Next page'
    },
    editLink: {
      pattern: 'https://github.com/YangguangZhou/Monet-All/blob/docs/docs/:path',
      text: 'Edit this page on GitHub'
    },
    algolia: {
      appId: 'T4RVBHOPQE',
      apiKey: 'f2da4e2a79ae9edc46037ffa47f8f019',
      indexName: 'monet-jerryz-com',
    },
    logo: 'https://img.examcoo.com/ask/7386438/202303/167966740456420.png',
  }
})

function nav() {
  return [
    { text: 'Guide', link: '/en/guide/introduction' },
    { text: 'Github', link: 'https://github.com/YangguangZhou/Monet-All' }
  ]
}

function sidebarGuide() {
  return [
    {
      text: 'Introduction',
      items: [
        { text: 'Monet All', link: '/en/guide/introduction' },
        { text: 'Included apps and authors', link: '/en/guide/apps' },
        { text: 'FAQ', link: '/en/guide/faq' },
      ]
    },
    {
      text: 'Download and install',
      items: [
        { text: 'Download', link: '/en/guide/download' },
        { text: 'Install', link: '/en/guide/install' },
        { text: 'ChangeLog', link: '/en/guide/changelog' },
        { text: 'Other applications and modules', link: '/en/guide/apks' },
      ]
    },
    {
      text: 'Other',
      items: [
        { text: 'Communication Group', link: '/en/guide/group' },
        { text: 'Donate', link: '/en/guide/donate' },
        { text: 'About the author', link: '/en/guide/about' },
      ]
    },
  ]
}


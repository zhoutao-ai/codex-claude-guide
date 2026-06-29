# 自定义域名 `lsgyl.xyz` 接入 Vercel 指南

已将你的域名 `lsgyl.xyz` 添加到 Vercel 项目 `zhoutao-s-projects/codex-claude-site` 中。
现在需要在域名注册商（万网/阿里云）后台配置 DNS，让域名指向 Vercel 服务器。

## 推荐方案：添加 A 记录（最简单，不影响邮箱等其它解析）

1. 登录你的域名注册商控制台（当前 nameserver 是 `dns31.hichina.com` / `dns32.hichina.com`，说明是万网/阿里云 DNS）。
2. 进入 **域名解析 / DNS 解析** 设置。
3. 添加一条 **A 记录**：
   - **主机记录**：`@`（表示根域名 `lsgyl.xyz`）
   - **记录类型**：`A`
   - **记录值**：`76.76.21.21`
   - **TTL**：默认即可（建议 600 秒）
4. （可选）如果你也想用 `www.lsgyl.xyz`，再加一条 **CNAME 记录**：
   - **主机记录**：`www`
   - **记录类型**：`CNAME`
   - **记录值**：`cname.vercel-dns.com`
   - **TTL**：默认即可
5. 保存后等待 DNS 生效，通常几分钟到 1 小时。

## 备选方案：修改 NS 服务器（把 DNS 完全交给 Vercel）

如果你不想手动管理每条 DNS 记录，可以把域名的 nameserver 改为：

- `ns1.vercel-dns.com`
- `ns2.vercel-dns.com`

> 注意：改 nameserver 后，原来的 MX、TXT 等记录会失效，如果你有用这个域名发邮件，请谨慎选择。

## 验证域名是否生效

配置完成后，在命令行运行：

```bash
nslookup lsgyl.xyz
```

如果返回 `76.76.21.21`，说明 A 记录已生效。

然后可以让 Vercel 立即验证：

```bash
cd C:/Users/GIGABYTE/WorkBuddy/2026-06-29-13-21-15/codex-claude-site
npx vercel@latest domains verify lsgyl.xyz
```

验证通过后，网站即可通过 `https://lsgyl.xyz` 访问。

## 完成后你将拥有三个可访问地址

| 地址 | 说明 |
|---|---|
| `https://lsgyl.xyz` | 你的自定义域名（推荐） |
| `https://cc-ai-guide.vercel.app` | Vercel 短别名 |
| `https://codex-claude-site.vercel.app` | Vercel 默认域名 |

## 常见问题

**Q：配置后访问显示 404？**  
A：说明 DNS 还没生效，或 Vercel 还没完成域名验证。等几分钟再刷新，或在命令行运行 `npx vercel@latest domains verify lsgyl.xyz`。

**Q：为什么 Vercel 要求 A 记录指向 `76.76.21.21`？**  
A：这是 Vercel 的入口 IP，所有指向它的域名都会被 Vercel 识别并分发到对应项目。

**Q：我想用 HTTPS，需要手动配置证书吗？**  
A：不需要。Vercel 会自动为自定义域名申请并续期 Let's Encrypt SSL 证书。
